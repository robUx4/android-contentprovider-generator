<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import java.util.Date;

<#if entity.hasContentProvider>
import android.content.ContentResolver;
import android.database.Cursor;
</#if>
import android.net.Uri;
<#if config.useAnnotations>
import android.support.annotation.NonNull;
</#if>

<#if entity.hasDatabaseSource>
import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
</#if>

import ${config.providerJavaPackage}.base.AbstractSelection;
<#list entity.joinedEntities as joinedEntity>
import ${config.providerJavaPackage}.${joinedEntity.packageName}.*;
</#list>

/**
 * Selection for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}Selection extends AbstractSelection<${entity.nameCamelCase}Selection> {
    public ${entity.nameCamelCase}Selection() {
    }
    <#if entity.keys?has_content>

    public ${entity.nameCamelCase}Selection(@NonNull ${entity.nameCamelCase}Key key) {
        <#if !entity.getFieldByName("_id")??>
        <#list entity.keys as key>
        <#if key.isForeign>${key.path?uncap_first}${key.nameCamelCase}<#else>${key.nameCamelCaseLowerCase}</#if>(key.get<#if key.isForeign>${key.path}</#if>${key.nameCamelCase}())<#if !(key_has_next)>;<#else>.and().</#if>
        </#list>
        <#else>
        if (key.getId() <= 0) {
        <#list entity.keys as key>
            <#if key.nameLowerCase != "_id">
            <#if key.isForeign>${key.path?uncap_first}${key.nameCamelCase}<#else>${key.nameCamelCaseLowerCase}</#if>(key.get<#if key.isForeign>${key.path}</#if>${key.nameCamelCase}())<#if !(key_has_next)>;<#else>.and().</#if>
            </#if>
        </#list>
        } else {
            id(key.getId());
        }
        </#if>
    }
    <#else>

    public ${entity.nameCamelCase}Selection(@NonNull ${entity.nameCamelCase}Model key) {
        id(key.getId());
    }
    </#if>
<#if !entity.hasContentProvider>

    @Deprecated
    @Override
    protected Uri baseUri() {
        throw new AssertionError("no Content Provider for ${entity.nameCamelCase}");
    }

    @Deprecated
    @Override
    public Uri uri() {
        throw new AssertionError("no Content Provider for ${entity.nameCamelCase}");
    }
<#else>

    @Override
    protected Uri baseUri() {
        return ${entity.nameCamelCase}Columns.CONTENT_URI;
    }

    /**
     * Query the given content resolver using this selection.
     *
     * @param contentResolver The content resolver to query.
     * @param projection A list of which columns to return. Passing null will return all columns, which is inefficient.
     * @param sortOrder How to order the rows, formatted as an SQL ORDER BY clause (excluding the ORDER BY itself). Passing null will use the default sort
     *            order, which may be unordered.
     * @return A {@code ${entity.nameCamelCase}Cursor} object, which is positioned before the first entry, or null.
     */
    public ${entity.nameCamelCase}Cursor query(ContentResolver contentResolver, String[] projection, String sortOrder) {
        Cursor cursor = contentResolver.query(uri(), projection, sel(), args(), sortOrder);
        if (cursor == null) return null;
        return new ${entity.nameCamelCase}Cursor(cursor);
    }

    /**
     * Equivalent of calling {@code query(contentResolver, projection, null}.
     */
    public ${entity.nameCamelCase}Cursor query(ContentResolver contentResolver, String[] projection) {
        return query(contentResolver, projection, null);
    }

    /**
     * Equivalent of calling {@code query(contentResolver, projection, null, null}.
     */
    public ${entity.nameCamelCase}Cursor query(ContentResolver contentResolver) {
        return query(contentResolver, null, null);
    }
</#if>
<#if entity.hasDatabaseSource>

    public ${entity.nameCamelCase}Cursor query(TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource) {
        return query(databaseSource, null);
    }

    public ${entity.nameCamelCase}Cursor query(TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource, String[] projection) {
        return query(databaseSource, projection, null);
    }

    public ${entity.nameCamelCase}Cursor query(TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource, String[] projection, String sortOrder) {
        return databaseSource.query(projection, sel(), args(), null, null, sortOrder, null);
    }

    public int delete(TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource) {
        return databaseSource.delete(sel(), args());
    }
</#if>

    public ${entity.nameCamelCase}Selection id(long... value) {
        addEquals("${entity.nameLowerCase}." + ${entity.nameCamelCase}Columns._ID, toObjectArray(value));
        return this;
    }
    <#list entity.getFieldsIncludingJoins() as field>
    <#if field.nameLowerCase != "_id">
    <#switch field.type.name()>
    <#case "BOOLEAN">

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>(${field.javaTypeSimpleName} value) {
        addEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
        return this;
    }
    <#break>
    <#default>

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>(${field.javaTypeSimpleName}... value) {
        addEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isConvertionNeeded>toObjectArray(value)<#else>value</#if>);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Not(${field.javaTypeSimpleName}... value) {
        addNotEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isConvertionNeeded>toObjectArray(value)<#else>value</#if>);
        return this;
    }

    </#switch>
    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>(<#if field.isNullable>Long<#else>long</#if>... value) {
        addEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value<#else>toObjectArray(value)</#if>);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>After(Date value) {
        addGreaterThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>AfterEq(Date value) {
        addGreaterThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Before(Date value) {
        addLessThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>BeforeEq(Date value) {
        addLessThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "INTEGER">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Gt(int value) {
        addGreaterThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>GtEq(int value) {
        addGreaterThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Lt(int value) {
        addLessThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>LtEq(int value) {
        addLessThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "LONG">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Gt(long value) {
        addGreaterThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>GtEq(long value) {
        addGreaterThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Lt(long value) {
        addLessThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>LtEq(long value) {
        addLessThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "FLOAT">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Gt(float value) {
        addGreaterThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>GtEq(float value) {
        addGreaterThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Lt(float value) {
        addLessThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>LtEq(float value) {
        addLessThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "DOUBLE">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Gt(double value) {
        addGreaterThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>GtEq(double value) {
        addGreaterThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Lt(double value) {
        addLessThan(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>LtEq(double value) {
        addLessThanOrEquals(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "STRING">
    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Like(String... value) {
        addLike(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>Contains(String... value) {
        addContains(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>StartsWith(String... value) {
        addStartsWith(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>EndsWith(String... value) {
        addEndsWith(${field.entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    </#switch>
    </#if>
    </#list>
}
